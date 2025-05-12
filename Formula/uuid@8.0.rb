# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "1611f3594f07c6bc077f620d00c595553f7ab3604eaff7b11f7799b4a6ed9198"
    sha256 cellar: :any,                 arm64_sonoma:  "4a70ddeeb5aacbb0a20f94f47e0c0968f630a6f9d6864433ad9a85fad78280bf"
    sha256 cellar: :any,                 arm64_ventura: "929f86ac1d3a65f75d46b7950a9c65373fe8f832351b94f2c5f2c2b1b19dd6be"
    sha256 cellar: :any,                 ventura:       "576d453e71ab21c499f0a8e7ccca3b784fe7bd604f031313e4622bcd5bc18d47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d18224fb684931b8e2f14406dce1abc440d3699278f07a3c159b994749426296"
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
