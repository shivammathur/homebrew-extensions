# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT73 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ef23cd70c3fef99ae0d8b7317a38f31b062becac65fc5265722c99099b10f468"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "69610d278f53e05fb2f3adf2661fae2d9c85be241298b87ac6ea2b6f8487a219"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4c2793a888ee18bfb9673d798d97756e9b7baae69312b3e6ec2da42d9a254ec8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4d2cebeda5979a0fea7088f73cca3d79d37b986a82810508b6e6c9c1a4cf8454"
    sha256 cellar: :any_skip_relocation, ventura:        "18633c16d09bb83ea2259ca7832f2940ffe5a4c85ea02f03245d581cf7fb973e"
    sha256 cellar: :any_skip_relocation, monterey:       "4f52767decfd3196bc2fa7839c00124ded100d23662733f93a478271a7b0a61f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5cf24940f6d84bcdb65d085d7de30b33b8a1d1ec562c89013f0fbc15ae471bea"
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
