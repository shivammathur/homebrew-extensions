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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b46dba8ea8e944935d91865f77df30f259378dc509a2cfbb2d253f46a5f7631c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4670f2ad20c4e25d10750e741f8b8b43808dc6e5cc8826ad5eeb8bc453b48105"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e6d28138caebc25f19d9048b6eb9abeb77c19c4271f25cce60b82b6c158fcbe4"
    sha256 cellar: :any_skip_relocation, ventura:       "5827bdfce688d6e5ec7ce83b1793c3664a2dd7fa26e43ffe68bb121f7db21d2b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "40c3fe9f08c279b45729e25d5016e38a12fb4ccd2c02976d6cc75496e51211fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43e8316c14b8a4b31ff4c7b64cc544349f895ef49ba613fd9d824333288278f6"
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
