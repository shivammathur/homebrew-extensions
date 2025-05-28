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
    sha256 cellar: :any,                 arm64_sequoia: "9cff1da1b771d54141f1fa84866cff15ba09e71408486b2bbfaadda7805099b8"
    sha256 cellar: :any,                 arm64_sonoma:  "a10b367b0a78656ff231863ab963dae2ab86fc66c30456d81307069f9d59a762"
    sha256 cellar: :any,                 arm64_ventura: "a59120593f023cda8c881c17746d989ea211f0de81981c6c5313928a16f0bfbc"
    sha256 cellar: :any,                 ventura:       "9693b71f5ee36de41924bad3e09798d45c3033321edd3ac80002b8c0b700c8ec"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6f6013954ea8309814cf155be01dccdee74aac68497e27dfb9f5b4253cdb7b3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e2768852e2df23934d6c9b3f6a7e842806f7ee5e7935919508a1cd07c7007c1f"
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
