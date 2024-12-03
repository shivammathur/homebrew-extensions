# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT84 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "55e3b7771326349e3f34c008767e272e1a77310b14785d8e37a6ead2edf977be"
    sha256 cellar: :any,                 arm64_sonoma:  "055d50642403a53c32e79e1863c859696b2e004d2724c32fb1c550d13510cf36"
    sha256 cellar: :any,                 arm64_ventura: "fe6c17f93195d4a5b554c942a74169786a887fb7e9f31ed63561751bb9843821"
    sha256 cellar: :any,                 ventura:       "1aa5f0721899a535fb755c60da82f0ac2d5bbdd59efbf03c542e5366a31628a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19904d963dfca6dfdd8938d64958136093f9775ce78995e85aefc1a29921e31c"
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
