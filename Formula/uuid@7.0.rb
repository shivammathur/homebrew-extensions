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
    sha256 cellar: :any,                 arm64_sequoia: "d8d109153bbc38a55e2208b86b6a539142a6f4cee5ad2518ca270ddc8993fda3"
    sha256 cellar: :any,                 arm64_sonoma:  "c846705cd98c5c020f2a40d2a7371bcd7299f0638b94fe7939736a23dbe87b95"
    sha256 cellar: :any,                 arm64_ventura: "275352c61cc66b9d9766f91b592082cbe9b7ce2b58585c5ddef0653909d78a17"
    sha256 cellar: :any,                 ventura:       "84c7578a9e52f9b8764046d7a74aeed5bb8dcd478e75ade0ec42b913cd9ddf70"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5279ab33f0c9972b9459879f12c8b93fbc2a1770567d9a72d3788a6b557a124d"
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
