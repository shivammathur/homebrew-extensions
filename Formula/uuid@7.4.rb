# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "a6ee959617945e48c07bf8c8d46685f677a7bdf10a39547f58c6b7c9a3ac0508"
    sha256 cellar: :any,                 arm64_sonoma:  "34a398eadaa929e3fe8c1d0cbb0c4f2a011876c34fb5f47c93f29689328cfab1"
    sha256 cellar: :any,                 arm64_ventura: "f17f64f42d41f1e50d486c168ed7852d50917be0082b0ddddc486f2a5d5089be"
    sha256 cellar: :any,                 ventura:       "bd1e1d11769cc3037973ad420c82b975dc11109247c1f089f8f38b6d0f8c5819"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6c6fc916e91e806140064d2ebdb74fbb0a28b8a3a1d1921cf3d883500a7881cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a60d593aaaf1dc9bab5b400fec3a1385ecf03089e63d95ccb6bf4ca7ecde1d98"
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
