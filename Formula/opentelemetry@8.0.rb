# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT80 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.1.tgz"
  sha256 "de8315ed3299536f327360a37f03618ab8684c02fbf8dfd8f489c025d88a6498"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f4698a9c3dac262c7b13e425c9653b7a13ee5b1d0ec9a4d114949b1a1698c894"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2baf524c858c03b868d440358a2db72756b2a05afd0c549f1db1bbcbf8da66cd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "aa9871a3e05008a1a3ba416aea4d796f2564da6ca7ee3a06ba4a9d9d65e38d67"
    sha256 cellar: :any_skip_relocation, sonoma:        "f47f08bdd38eec3b902547f3d4de52f1653ef5ad1ff7636748a981dbcc23036e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aead1c1a3396d8b4b10e443e668c67d309e14167925a9e3ab75d3c481248d400"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1e405b0b78a18b9bc941e7b0308686c06f9691f6bfe3e877f1989c454ecd6ffa"
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
