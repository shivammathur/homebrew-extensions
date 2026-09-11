# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT80 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.4.1.tgz"
  sha256 "981edebd3d01b942a7863af097316d725922467699b16d0a70ccf56f37c14a04"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b7fb10626271ae1387404940af6d298ab18c8394ed136b1e131be7721467f808"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a6b056939218114c4fe01089ff801e95cec2538a7a7d2b6e8de579c6bb2e3933"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e038d51a48e9179ed1074a3f4d2e05bda36b71401c4c5f76393ed4a774689b4a"
    sha256 cellar: :any,                 arm64_linux:   "51d497da7f62d626321f5ce3f5ee36ba7cef15209cf709f336c2213803d7deee"
    sha256 cellar: :any,                 x86_64_linux:  "ed480c39a1884e2fddc402ff8954d4cf125cf807cc1d7e06ebb90facc28e4f60"
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
