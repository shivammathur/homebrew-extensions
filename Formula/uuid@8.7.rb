# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT87 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.3.0.tgz"
  sha256 "b7af055e2c409622f8c5e6242d1c526c00e011a93c39b10ca28040b908da3f37"
  revision 2
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  livecheck do
    url "https://pecl.php.net/rest/r/uuid/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "eeaba6c6cc9b94ad1eff896c9deaef5db81bbee29521da0c5a1f6e5973824bb7"
    sha256 cellar: :any, arm64_tahoe:       "75d5d7465fe50f90918070018f5092ab68deb92fe5684d18ac6030cf63f846af"
    sha256 cellar: :any, arm64_sequoia:     "920d7a8970d0faa2f683e6c1cd49eddbb2dadc81cef5a3ab0617c19610fbdeb7"
    sha256 cellar: :any, arm64_linux:       "2d2f866307b92040cd197ba4d64bac607ed1d72c34f92877d44baf38572cfa94"
    sha256 cellar: :any, x86_64_linux:      "a40a5158888557de561cb0bd67d3de8f800c584d09f16a3e76739116723ee8ba"
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
      --with-uuid=#{Utils::Path.formula_opt_prefix(uuid_dependency)}
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
