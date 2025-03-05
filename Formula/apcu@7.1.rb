# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT71 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0aa1dc0af5cfa84e8ea6f711a66eb1a6cf46765634e111a55652e372d01faed7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ed002b76cc4207a747e4dd6849ef457af228f9a9a4d888a4742f306046808e71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8d8e1c3f1b11e72163136830479966ef6d6d62b23969c8724f4141cfb2526ff9"
    sha256 cellar: :any_skip_relocation, ventura:       "a894ec816b9cf7b59c7b21fac2f955513ce63d7b00181b6b1dd5c50219b33fc3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e9a0c9ef5d031376a9801b19a84ae047337e0abc4b1e3a0a4b5219a3dac31dab"
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
