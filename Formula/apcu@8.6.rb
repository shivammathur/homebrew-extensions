# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT86 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.27.tgz"
  sha256 "1a2c37fcad2ae2a1aea779cd6ca9353d8b38d4e27dde2327c52ff3892dfadb3f"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "aaec4a0e53ce83c1516875511d5f259aafd45cb760405c191ac76ac0b714b59e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9ffefe20d24df3b8cfbf5ff64f40a767cbe287bd07404ec8198b61147623913e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0488e1aef72fc799d5a5eb7577bc85a2248dd2edf6780a34b5fdc2bfeaeb4f3b"
    sha256 cellar: :any_skip_relocation, sonoma:        "029dd4ac080038186d858c9a8ad1f27cfe6959bf950024029742544b4a468018"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "afa81b8b350e98ff22dd008a46539813d42a5e989071279fe4151cd542de5e6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b1bd4e42ee8db297cc37293693624cdfb1e5cb7557d286cb6d8c131b7e81cd2b"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
