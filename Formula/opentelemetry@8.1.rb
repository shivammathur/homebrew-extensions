# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT81 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.1.2.tgz"
  sha256 "43000b9b95d1c10a072a4dce631628dbd8e48af5cac6cd6cbe3b0649ed5fd2d6"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3c40f580dc2c1de9f5cd0f33707e580a7f8347c7aecfe91a0f6c186637e22cbd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fcd494c54c7e24e1e1920328b1a8aa72247e8f40d1002af60076a25552ebaa53"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3ace21c6e5f87f907f50f51e4793c3c300b6fefd74bcbce9db718fc321d103b7"
    sha256 cellar: :any_skip_relocation, ventura:       "9d25da9d92660343ef4cece87d0e21d808349f83212e2e738be9692c46e4a828"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64c1d6512872f216c8edfd169b4ead9c3fa997243c4ef838fd9691772200da18"
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
