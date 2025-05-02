# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT84 < AbstractPhpExtension
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
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "225abc150d1cac607b00268101bdea77e969ded04d18ec2e499814907d1ab0a2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "024233a825d70c0dca2e447e9eb86d4ec2b4a2217b6d715f74959bdffdefec90"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3312fd87b0ebfdd40ec341b1330392d006785e5af97ec5232bb26183406bfb77"
    sha256 cellar: :any_skip_relocation, ventura:       "686c553274993042c3b7c24a095e4ac045d454c418d528e0cd3b3ac7201f07b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8d499b452550600e4a7436a6072bc8583b5c28ee046ad62c43dac1f436d5900c"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
