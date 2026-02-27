# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT84 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.0.tgz"
  sha256 "31d6c2835a05a7b6ed0f0ddb67556ca914652a57a571c26891f02d8ad99b7e5c"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "acdce380cd20054182e729c199f8dfbbd84700256b4cbe7fa96aefcb349987eb"
    sha256 cellar: :any,                 arm64_sequoia: "ed20fff372f5519c71616fae20fbbe1d17dee088cb7deb0a6693378f00c76344"
    sha256 cellar: :any,                 arm64_sonoma:  "fb95ae087bf3b2d59326e08d355a56768609aa9b0416588a4683a3011702dc8f"
    sha256 cellar: :any,                 sonoma:        "3174432a0b03e1186a96475ebdff71bcc14629427cfb98b68eb40d509042b16e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "53fffe46a9f8bfebcbe195e149341dabc9f9c26722c5782d1a95b219052614c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "baee4e417e38ae142d9f163b16bb38a710012a0854dd26eabd5c92a30ebded5e"
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
