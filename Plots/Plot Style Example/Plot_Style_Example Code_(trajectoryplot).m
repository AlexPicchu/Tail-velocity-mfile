% PLOT STYLE EXAMPLE CODE


% Trajectory Plot

    ftrajectory = figure;
    ftrajectory.Position = [ 0 0 FigSize FigSize];
    
    axTrajS = nexttile;
    plot(transpose(X_SOLNs(1:2:end,:)),transpose(X_SOLNs(2:2:end,:)),'linewidth',w) % trajectory of aircraft
    title('\textbf{Trajectory} $y$ - $x$','Interpreter','latex','fontsize',TitleSize)
    xlabel('$x$, metres','Interpreter','latex','fontsize',LabelSize)
    ylabel('$y$, metres','Interpreter','latex','fontsize',LabelSize)
    a = gca;
    a.TickLabelInterpreter = 'latex';
    grid on
    legend(LegLabels,'Interpreter','latex','fontsize',LegSize)
    
    axTrajL = nexttile;
    plot(transpose(X_SOLNs(1:2:end,:)),transpose(X_SOLNs(2:2:end,:)),'linewidth',w) % trajectory of aircraft
    title('\textbf{Trajectory} $y$ - $x$','Interpreter','latex','fontsize',TitleSize)
    xlabel('$x$, metres','Interpreter','latex','fontsize',LabelSize)
    ylabel('$y$, metres','Interpreter','latex','fontsize',LabelSize)
    a = gca;
    a.TickLabelInterpreter = 'latex';
    grid on
    legend(LegLabels,'Interpreter','latex','fontsize',LegSize)
    
    axis(axTrajS,[0 300 -0.05 0.85])
    legend(axTrajS,'location','northeast')
    axis(axTrajL,[0 1500 -0.6 0.85])
    legend(axTrajL,'location','north')
    
    exportgraphics(ftrajectory,'trajectoryplot.pdf','ContentType','vector')