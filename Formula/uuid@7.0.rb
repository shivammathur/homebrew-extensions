# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT70 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.3.0.tgz"
  sha256 "b7af055e2c409622f8c5e6242d1c526c00e011a93c39b10ca28040b908da3f37"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  livecheck do
    url "https://pecl.php.net/rest/r/uuid/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "2ecc3077d529c6fb7196c064d64b69e8cc833c09c9d6d26360d3fc333c0738c5"
    sha256 cellar: :any,                 arm64_sonoma:  "de6acef3af12f11cbca436ffd4cd51bb5456313a51bc1a5606d07ec7fd8a449f"
    sha256 cellar: :any,                 arm64_ventura: "8d7fd2c80218bf32887566c0ab165c1ab9c75c77a6dc52feed45dc395abbba09"
    sha256 cellar: :any,                 sonoma:        "b680b6b880f9357a625db3bc7599e1034b1ecf63bcb90c71b0ff464aa3782c7e"
    sha256 cellar: :any,                 ventura:       "205fa6656343a5e013193907f74b6e8bea32dfb2a3404dcf6973cca2305c2aed"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "773c04d54586eb1ddb2354beeac3ea04df43f652b8164518a0195b297b9af876"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "23bedc2b338e8daf35a22ab25cfd99d854829720c0cf65a204d2ae138c6c4066"
  end

  def uuid_dependency
    if OS.linux?
      "util-linux"
    else
      "e2fsprogs"
    end
  end

  on_macos do
    depends_on "e2fsprogs"
  end

  on_linux do
    depends_on "util-linux"
  end

  def install
    args = %W[
      --with-uuid=#{Formula[uuid_dependency].opt_prefix}
    ]
    Dir.chdir "uuid-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
