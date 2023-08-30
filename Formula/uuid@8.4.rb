# typed: false
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
    sha256 cellar: :any,                 arm64_monterey: "368314e551478b7a196a017f8891cdd39174e805f7804e6e8287a24ba0a6b622"
    sha256 cellar: :any,                 arm64_big_sur:  "7502be45d4fb6132741aaca70b04401aae7ff1e99264f88e34cb509caf1c12eb"
    sha256 cellar: :any,                 ventura:        "0a7caea5eda8bd6466c719b641420622521969fad1d0feeeec499deffb4dea80"
    sha256 cellar: :any,                 monterey:       "1a99f0566b0d21a0fe39099273271650b17e66dba99489fdb9192da7457bf638"
    sha256 cellar: :any,                 big_sur:        "6a2d4f333ff396f987eeacff1993f7e9e25fc37c6a0ec2c24dfd5c7229f7f8de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6fa6176b91f032e6932835b4580c4ea65617178f20148c7c2a815c23954c5b26"
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
