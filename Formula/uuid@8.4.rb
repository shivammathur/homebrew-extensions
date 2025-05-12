# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "f2ee90ffa140273d44691bbcba6dc562e7e61eb6d3837bab9c46f9781878fcb1"
    sha256 cellar: :any,                 arm64_sonoma:  "8c702b67f363e92aa84e756dc278bd63be77e3edda0c6d7a849356b8232a125d"
    sha256 cellar: :any,                 arm64_ventura: "ee996eb25a22956744b54a415e13ecc05e85394bfe305c8e1f7019bf670645a4"
    sha256 cellar: :any,                 ventura:       "7d7fb787d0f51c6d31434cf803dfb18f06b961a396bff6bc28d9ddf98ecf41c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a2387f9da188cca07010511458cd9f25667e350e3b1ab1ecd1c21a3c24b750e"
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
