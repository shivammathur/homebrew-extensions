# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "e09347890454e3105d49bd7b99acc62392bb2340a0bdd88d532054cfa580a1fe"
    sha256 cellar: :any,                 arm64_sonoma:  "aa37c7bb5c97035798a12a764527666aa376dab3cd87689b8b3a4af468b369c2"
    sha256 cellar: :any,                 arm64_ventura: "046c261913f084fd94f9398128b548cee2fe9bfa1b0c3df28a3aa104f157fe92"
    sha256 cellar: :any,                 ventura:       "e75aeb44e8a65a7b4082c7e6774287e2bf416a60bd0c91b6f657f01236052aa0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a1fd610f20f3efcf4627ae3369f0b17fa00bc27fa5256100a01f6afaca7a00c6"
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
