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
    sha256 cellar: :any, arm64_tahoe:   "31f32f4bbbbd16aaddfa0f6f72ae339705d0b2a684bf88ca2c7947b706b9df57"
    sha256 cellar: :any, arm64_sequoia: "526d37e6674719582b115e60a467627db372b8b5017cf3bd32b86d5ebf53d99e"
    sha256 cellar: :any, arm64_sonoma:  "b1eb000fd93a7aaf499555dec27d6f6da9bf7bd0c1e1b996c011f9833603ab4c"
    sha256 cellar: :any, sonoma:        "7365aebf01b6a4e36f5651989c6ae529faffffcad99d7da59e4ed8468ec13736"
    sha256 cellar: :any, arm64_linux:   "0f6881ff786fb05c87580714ad3876d02036e3110be0dbdfdd6ad26798e25389"
    sha256 cellar: :any, x86_64_linux:  "51320cc758afeb5286a805e8af209c483ad73fa3514156b74ecc981242f5deb7"
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
