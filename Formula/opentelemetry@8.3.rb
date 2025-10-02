# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f847fa35d34be78bcbae192c5c0af9cbdc038f1f8199b3c3f0f53ffe8be68ebc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fa6136c4500f6d0ea7398a3aab0041c8280ed80657690507784f1c4c80185130"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "af6e12dec5c95b76d421142b6d96a0be14b1a20855b61555f770083a43e6b218"
    sha256 cellar: :any_skip_relocation, sonoma:        "8306bf6b5776e679b0c2ffb8f7e56ddc9c269e5542abb6bd9cda67a2428dea28"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "568a4152d71f2112c7a8086605a0e6a4859ee4f6155479f6bde054e4a869c59d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bb245a5c08d5ff61bb3c00437951b18727fc838b260e7153369e279fdaee9a25"
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
