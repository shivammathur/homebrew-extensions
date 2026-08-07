# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT82 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.3.tgz"
  sha256 "1c3092ca793bb67002ca022c412aacabb79a3297ee7005e3b7cc91b1e7166d22"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "164e2d49cf6475ef06eef4a3d9f919a49e5a1aaca9c7f468e5c1385d36f43ccf"
    sha256 cellar: :any, arm64_sequoia: "b109bcfce4b03affbdf7ea24f3687b045d36437f60a7f7ea7a14a7eb8800ff1f"
    sha256 cellar: :any, arm64_sonoma:  "a53b0190eb250824f93e77a371503b398761d4f69f27a815dcc188c23336af89"
    sha256 cellar: :any, sonoma:        "739fe8ff1671fdf2b7f4a18c5dc7942534d16cdb0cf4b1f4c5cb64b1610a29c8"
    sha256 cellar: :any, arm64_linux:   "4f4a96eb0442bede3e67a724d1e7b32599783bb6169bf31c665b6ac3d799c232"
    sha256 cellar: :any, x86_64_linux:  "7326f8681e11b11a3be62c1e2d50ea26fdd1e2efd32356caaff3dd38fcd36017"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
