# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT80 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fa0fa8d4f72df8e91ce0c4d04f69d677661263a522f4a197d87a6ada9b3b4d6c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "36cd47801fd3ffceb2f4fb35786048cbd2c18ef3a5362ef1f86c34eb516d055c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7954b0f447ecf8afd31ad7176512dc2590257873955572b3e929096cdea781e8"
    sha256 cellar: :any_skip_relocation, ventura:       "ec24fe3e6d3c05c159dffcdfc784c4a537bd0b6a325d05465a0442cc8f2ac092"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "566e582a83b479ffd85e6d5c4fad4e59060a9199035bb94cbe2f841ddcbad186"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "38f5a4e045840bafcbb7aea2cb0ac949df7b915c1eeb3c4afbe4102760775765"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
