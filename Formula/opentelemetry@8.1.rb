# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT81 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.1.tgz"
  sha256 "de8315ed3299536f327360a37f03618ab8684c02fbf8dfd8f489c025d88a6498"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a149a61f942f19af0507fbf5b88535568cc89244bd74171cf4952427089c3b88"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d4d3fd888790fbad921b038b9e26baf0c3cd19a314d7e89e8f1a3656dc539716"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3d90eccac039202dc0bc0af332bfb8e42374866cce8df44ab5643510928dc739"
    sha256 cellar: :any_skip_relocation, sonoma:        "fdb58dbf948861101a424d8cb90918ed9ef7ae783ca01b11bd8fcee058310ed5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3cc02ec5a26441f5a9d670a4b0f7b798e00e99e7cd36650be2f2f826e5dbeffb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ebbe925f4f05ee684c768f1e1432f2058c660a2767f46d70807215289efb0040"
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
