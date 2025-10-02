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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "88f798485e0e55ac73e740665c4c759367b77cb3a4d8aab114ce34c9306800bc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ab48c4b73ad9d6888399416c223422afa1dcff32fd3f68245a6121eec5280c22"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8508e90b14c2c6419417d0d5444f5cf6f7a7c7210bc16a0fba52194121e3521c"
    sha256 cellar: :any_skip_relocation, ventura:       "0ce9dcca2c016d2b93f4416aaf773a5e665e9abb513e1394c2b04efc353ec90f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d7de313121cecbbffbdb256024aa34dafad5f138380cb6620fb89eeb2e6ad426"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "38ce4866f730922c57a956250ce1e725f15aa47953c9b1d1017d196220d208ce"
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
