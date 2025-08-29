# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a466a4070b68f4f3cedfe90a44af54beb073fa0352d32e2d669f9e9e722d1de1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cdcffdb3f4376474f4a9c4932c0441aedbb61713a9f81a8d847b5528050b480c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b5e58462d24b88ffd41c261d1490e42fc6e92244358f9463bb240afe18e7c7df"
    sha256 cellar: :any_skip_relocation, ventura:       "fcce600fa4da82032e467f0f4dd26e6051d2c964416614fe59b5874b9efc4d9f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f6cfbb7116285fffe730153aa25b1d4a14d38079ba556e56cca26d4563e695c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4dee37897c1b5fd3e3849aa2efbfbf69293c0d83e0ec17a7a51257195780a168"
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
