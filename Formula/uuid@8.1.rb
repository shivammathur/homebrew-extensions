# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "67b5c1b01c445bd97c641c52d03399dbd96c4f7cea8f03f6e8daafec7a8693c0"
    sha256 cellar: :any,                 arm64_sonoma:  "ff235b3fbe069e5c34bb27d126f073d9d6e65ac36945e3745168b7506923149a"
    sha256 cellar: :any,                 arm64_ventura: "e11a34fcee66213fe11a09a263f095f64f8e56f5387fe544afc8d350aa30479e"
    sha256 cellar: :any,                 ventura:       "5c4064ffca4f21c8365149caf7244b626c94ac655969ab067781933be3dea2b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db4c29fa168f9f4873bfa482cf79cf0bc0c18469e95e22e038f3beabaaaeb028"
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
