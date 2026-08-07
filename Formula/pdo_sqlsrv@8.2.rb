# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT82 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.3.tgz"
  sha256 "198a7b37da0658d36a93d158a0ec179b137b3a4d241c90a6650ae9ee8f91ec4a"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "e30f51c7eef589bc5398bb32baeadaffc1330a64e9cb516b02659f22db3a343f"
    sha256 cellar: :any, arm64_sequoia: "34428fb439057f48c6be9ba9dff0508f3176338b585efa81bf0d070318990aa1"
    sha256 cellar: :any, arm64_sonoma:  "7a19c371f6e32489647b221cbead12cf3a67525c03601ab7ce3a2889fefbc549"
    sha256 cellar: :any, sonoma:        "0e84f553222dcdb0a962bb47e16b7b9f9f2b647e8b902d0e2ffb6355997811ad"
    sha256 cellar: :any, arm64_linux:   "acd1100b0661e30ecb5408e20ce85d300e4ac595fdd3cf11d97feed7f4fad28c"
    sha256 cellar: :any, x86_64_linux:  "ab15c31935a4b8b83f2ff8e776c709d125536284ea35f3b398bcba3796b96ee4"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
