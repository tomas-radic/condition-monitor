module PhasesHelper
  def phase_name_class(phase)
    phase.completed? ? 'striketrough' : ''
  end
end
