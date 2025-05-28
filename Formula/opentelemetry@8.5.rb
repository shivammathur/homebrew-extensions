# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3d5f1a8120e784a21133885b68772e7d5b350bff40bf4ee41fd3c73c0aad8631"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7eca4cf9dfba26dec1b42dfffe4260ba02ac65d5be61b1c88d2387ab73b0b2b4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6562fdc5838a3ec05b8aec1ed1906445e3e0e9a6f6d672c66cc6be393744000d"
    sha256 cellar: :any_skip_relocation, ventura:       "72ed3430f253d575d424587d89e8dd2e46e22b157f5abf486ef10e6980c1e9d7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b590a35d4d6b0ad2e460ee39d7462736435d67a81836b2f8a0ba0e83fdda7cfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1852d87363d9d07ff4d0c9acb36dadb61e61b61191e2cee9ff71abdef717ae65"
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
