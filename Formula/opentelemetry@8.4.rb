# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.0.0.tgz"
  sha256 "c986887f3d97568e9457cdeae41f4b4c1ed92b340b7533ecf65945eb7e291f74"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "59d8a58d3796ddbe3b0a6d9790e06fb926e78f951744699b742581dc1b30afae"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ad59d71ce99c66e0aede9ad0083d1a484939b873d2a3069ef0f46b80a9ab4f31"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "25d8694a71a6be85cd66affc2b372c6131967315233e5995185a782b22500775"
    sha256 cellar: :any_skip_relocation, ventura:       "f86a05919209923ec7c93d92dbc1e3bbf2ddfa74c88d226498bec16a41ad553c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04b4795bdf3d1d5de00233190ec87d8aafa7ba34618dd2a490f44254ce04a329"
  end

  def install
    Dir.chdir "opentelemetry-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
