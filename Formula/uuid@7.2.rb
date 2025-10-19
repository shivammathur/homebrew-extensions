# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "18b081b34820d76838d32ebe6dbc99c1cd554202f9c83e2c433ae948dde8005c"
    sha256 cellar: :any,                 arm64_sonoma:  "59300ec51ae9fad55d0262652cd68370035c39dadb086b3c2caca56ffe6c79a7"
    sha256 cellar: :any,                 arm64_ventura: "c91029b380e8ffdc927c4cbdf4d45ea3a761409bf2b4e99d2cdf0ef1a5af0a4c"
    sha256 cellar: :any,                 sonoma:        "757f1c9576182e97d7b446e3640a15a06f828db218972f91c1c1e5ec48faa201"
    sha256 cellar: :any,                 ventura:       "b375151ef1b06082d19e95d7be5bab8420ef40581aff99a88e5f3296877ec6a1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aef83d3255238eb3dcfb4a974c131f6d477037c97af3f3f54b8e6d8c8a532864"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4d45fee26c54fabb2b01c3781ab39e58233863336d27f7dfc0500de70a9bf7a"
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
