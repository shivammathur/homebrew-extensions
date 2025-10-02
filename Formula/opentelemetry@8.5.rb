# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b12bc7b6057c12fda5d8b191c16a1cc168c564f428ae0a44cdb23cc2739df335"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "08821fbf139427512b42f4f2823881d4e75cf5c1aa792c89df18f089234b5c6f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a4ac2c7b53cfa73a535ba9c6a58f39cb41dbb996c2a943a8a99fca852b55f077"
    sha256 cellar: :any_skip_relocation, sonoma:        "558744c3c1624a5b6e734273b6760bbff08bbb24b7e46220f13b02400f6934cc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d3382ed6fc93cffe24d005b8bd9957800447adfbc60024655d4aba33d9a44c1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "beec4ac53775522556d4cc854673c8a047b1e78bac46bee8969f6b1996524f46"
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
