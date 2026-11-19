# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT85 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "5723d6934bdcd33fc56763ff50491b257eedf45b35b0a11e48dd51c1f138db29"
    sha256 cellar: :any, arm64_tahoe:       "27ebd6a26a24c2cd999f2b5027747fa8643a888ced1ee286ab5e155cc3c9e043"
    sha256 cellar: :any, arm64_sequoia:     "2dd0c643e4335455b48159eae36a722281a10eb6f3223412e4ef5caeff64f529"
    sha256 cellar: :any, arm64_linux:       "a6f64619610c07dfc1d791a7a7f7099e789d6ab1eafa30e71e42ab5aeb542eb0"
    sha256 cellar: :any, x86_64_linux:      "a8e5b8a5954020cb96eb3198c69edc2aca9b22e992fdc567f6e0b325d94a189b"
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
