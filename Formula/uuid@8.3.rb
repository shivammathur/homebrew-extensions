# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "460a2f23cf76ef814419fc8bc2ec022415b778839ac96252b07bd0f6c1eda064"
    sha256 cellar: :any,                 arm64_sonoma:  "1104cf3c723c152857b55cb56913f5d1bba18df162039d8e8b7e593acaa4822a"
    sha256 cellar: :any,                 arm64_ventura: "43e799e47cf1fabd266ca0ea269e5eb31837334556ec6907d33ae9ae66bc63ce"
    sha256 cellar: :any,                 ventura:       "ff3209f7cbeffa775cf8ceb5ba4cf7609448c39e9dafff2f925bbc4f953fb371"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5392610e1c244322795810b0fe31814e7275d9d5a8c3c9892b7e9b4ca0cc909"
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
