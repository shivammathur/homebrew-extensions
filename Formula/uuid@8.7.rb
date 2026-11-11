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
  revision 1
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  livecheck do
    url "https://pecl.php.net/rest/r/uuid/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "9394decb5a3a51b44f93673190e0ec54f8908d59f63527bac6af4a73bb83dd04"
    sha256 cellar: :any, arm64_tahoe:       "1b22c102020718aae62583a007203e0bcc3043b359936658fd5a741586c037ea"
    sha256 cellar: :any, arm64_sequoia:     "3b8f4e2632862cbd8b775e2293ae38b566e7f4017a178a7a7d6b3ab1be593df0"
    sha256 cellar: :any, arm64_linux:       "ca698f2c594df088857ece00282068e93bd217afe54d5b8bd0c80ef827ed945e"
    sha256 cellar: :any, x86_64_linux:      "e7ae6cb27a6fb28c6edc988ea64c503eb247f0ab7d8cf84dabfd89b02f9a63db"
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
