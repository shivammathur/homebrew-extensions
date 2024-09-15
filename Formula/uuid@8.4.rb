# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT84 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "313dc8cc1e9a0803ce975abbcc5fd95152f92a8c6f87c60b555fa177c25fd949"
    sha256 cellar: :any,                 arm64_sonoma:   "51672c242539007c6027d53ecc6d8b0a7ccd4fcf896ed0750748085b18f3a209"
    sha256 cellar: :any,                 arm64_ventura:  "94d04dd4fe3bbf48902428ab970407a59c46e8d9e323c71e360d75918015191a"
    sha256 cellar: :any,                 arm64_monterey: "eaf5ace44da7ea2426f741b84ace8fd71ba61d5b5a6516d26a00a1630cf9b894"
    sha256 cellar: :any,                 ventura:        "726869bfaf673ad185a45064694062797d382a7170c9d1bbf33137831a547f47"
    sha256 cellar: :any,                 monterey:       "9fd708b7fb91fb9c0d197c1cb17de1c732299edd292968ae28f39864675b7621"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "629c8f2f95b5ba6a1204b9b4424249e451fa72722dacd8fa1c9767279b7be3d0"
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
