# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT85 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.26.tgz"
  sha256 "aed8d359d98c33723b65e4ba58e5422e5cf794c54fbd2241be31f83a49b44dde"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e44a60602fdebc8bc3548e5cdca2ecf40105ccfcb8184a243bc162470acf4dc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a2e40b5bfdb3572de6cb0989bc35e8bcffd4514317d357781fa5ef73171f19ea"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "42b4a6accdee6a87a69cf33954c199bdcc49aceeaf8750193c7ea10636ae9f8e"
    sha256 cellar: :any_skip_relocation, ventura:       "3042025a461b85608145e4ad2a644319afcbab318134133b288d1a0b3a41f913"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fa88a1023307aedf9b22eff00fd2a84e4678f6df6826427b8940fbd4368d4add"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d1b8dfabedd2bf494eadf95674bfdf9a546a25ac64454902b17f5637aa840e2"
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
