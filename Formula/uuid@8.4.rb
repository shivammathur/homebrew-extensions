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
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "97d20e0a8445ecebcd78f6907187e157f8816dbc2a2d2563a86241257dc90bd3"
    sha256 cellar: :any,                 arm64_ventura:  "454426e3e860d0d0d6efa195efd9329f08686e5c561b2e98ef775a34bc434f05"
    sha256 cellar: :any,                 arm64_monterey: "de60caaf620ace281d376c8132aaf78f798d255443363a074120f10bbf291b64"
    sha256 cellar: :any,                 ventura:        "9edb3722486a35c418eea2c00018a143830b7f5360c87590b30242e9a1a998b5"
    sha256 cellar: :any,                 monterey:       "7a180dabc9a6e7a6372f0ff556b51da0e46b08507f88505268f342db9b19a082"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "61c84da631650fe925e2f15f5fddaf944219cc0c2b2808bcc0f9e013a2aa135c"
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
