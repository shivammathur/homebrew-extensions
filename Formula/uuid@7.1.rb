# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "0ded6d6816cda75fd9682786a8ce2ef34656d8617233f65d6cf6f9b617292e6d"
    sha256 cellar: :any,                 arm64_sonoma:  "bbdc7d15a1f062ea219485798bd664e413f2ae2e78c94ad7ebd488e1b8864082"
    sha256 cellar: :any,                 arm64_ventura: "b114e21f1970a26a50d81f845dacb040045d6e3d308cf579902fba0fdfa27368"
    sha256 cellar: :any,                 sonoma:        "1e6aa9c1fcaad9a04ccfc8674b223afb5aafac44a529ff21bc645b3d49e38df4"
    sha256 cellar: :any,                 ventura:       "bf58ac7d7dad15c72f0b0523d1ae14031dbff6a0358b040659f3cd307a9d7cbe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f9cca10885383c8d4df9f194a6e5ba09fd0b9242dbc167a6153a713ad6b73a29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a85dead91f08617f0c91fdf19fbda63ceffc632097ca8a9ab7e7d5c77e5f9614"
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
