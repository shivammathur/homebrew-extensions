# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.1.3.tgz"
  sha256 "8371225bbc4dbd6ba3e966b1588c22c81c6a87fcbece64cd2b3294cc03b2885d"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bc41f290120d46be4c0e537cfc89d6b52f86c89fbe7a96dbedaa16cf3b690db2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c5026f4cecf6efd92ea6ad24c6a0927c686b5164ccfa45785a7dc76ba747228b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "aeb843d42f50e6387dd8f56010fa0005088a8a63b37452d88896d7ab4825858b"
    sha256 cellar: :any_skip_relocation, ventura:       "5a52aab3458c679d4541beeedd0f74de5864f8e5763269d8b83f1c42a4c2055a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3b95ac9a7bb1177bc832c3fe8f83257d114c0e52389f01916a207a7e8ded7f84"
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
