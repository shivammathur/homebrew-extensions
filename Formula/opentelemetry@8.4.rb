# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.0.tgz"
  sha256 "50cd327c7494b5f436631434c8a5f0554aec129e6d499ba61359131ebf1b6757"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "87ffcd02733583e8df661deb24d58add240e8a2e2a6e76016b523b87cac4902c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "25bcd82972faa9ce3360f33893c9f8945781597399f9eac5cefabd4e0664bd8c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ac6855cd21af2aaa154e2de17c2aac8208647daee2c6de38d8d60b83ebfc42d5"
    sha256 cellar: :any_skip_relocation, ventura:       "9d2e8ebd38fa45aa33acde8809f93deb5b8862fb46a30e05ceac200d162a66c7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "04325077547b0b719d04946789c14e2830f2b47fbc079627524022b9220dbf64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "78548254c1f3efbc711d5b4276a6bafce0309b31b8695ffd1bca76cc00d71773"
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
