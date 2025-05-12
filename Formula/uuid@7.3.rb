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
    sha256 cellar: :any,                 arm64_sequoia: "0f0530cd6fa08293b2aa625d3baf4f98a94ce09acea024b07ededb108f330fdd"
    sha256 cellar: :any,                 arm64_sonoma:  "143428a80af66e92b3990b5488128c66b4d6dd9cad6222392b25e9afb356048f"
    sha256 cellar: :any,                 arm64_ventura: "9a3da331297a73b9f06950b294505386e578f41f443d9252507a9dc6fc6c38cc"
    sha256 cellar: :any,                 ventura:       "650ce5110599ac9487fbd8ca20b37c5895402587ebe462fc987fce7f283d935a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f58e6985bb8fafac617fc94994fb337b24237f49e8c43fce066e339808c9fef2"
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
