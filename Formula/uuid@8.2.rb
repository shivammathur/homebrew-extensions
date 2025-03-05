# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT82 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  livecheck do
    url "https://pecl.php.net/rest/r/uuid/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "166557904d7658d445b8f3afc4025da7576c9d0e1546d07cdc37fc09c76688d9"
    sha256 cellar: :any,                 arm64_sonoma:  "6adaaa86f19b9fcbfcd481ed7a30631f4db57cf496468ac52e295f8fb6ce8074"
    sha256 cellar: :any,                 arm64_ventura: "2e1632a501fcbbf460bb2cb801a2ff46a4740bf458565ebd0cd1525d18054903"
    sha256 cellar: :any,                 ventura:       "a131b1129d63976efd02ecac5ccfb8ad5b7eb302f490aec6a54cc4f75a396f7c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f76e0bfabc4b311a73a68e7f0b5e2752f90772ac6d7225a7b4011575fe301667"
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
