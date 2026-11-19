# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT74 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.15.0.tgz"
  sha256 "49412f02d31d28861f56c05f043ed21a1e8c444b53ac47292da502a4d1fdaa2b"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "935c34276388a4094097a8537b56644f9d501dbca9e861ec5a5e9ff0105d901e"
    sha256 cellar: :any, arm64_tahoe:       "fadb2bfa7dd0a52c62590ddfbfc488ddd3a9d111286e9ba143608c74aaab9a31"
    sha256 cellar: :any, arm64_sequoia:     "fd78276f8d67fc176371b5f48fec29e8abf29be635813ff55f25fb53a18a2558"
    sha256 cellar: :any, arm64_linux:       "1f384c3d54dbc24b899397d8eb976c8aca4789286f7805e015ef245502ceb855"
    sha256 cellar: :any, x86_64_linux:      "7c4b549d8b9ee504d92573e9c0593155dfe33bc76dd64f2e4b1721b742ab92b3"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
