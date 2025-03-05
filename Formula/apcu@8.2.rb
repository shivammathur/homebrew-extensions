# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fb7263a1b3dd268ed2ced1b70754856f05fe048bb5d197b59b6f0a5b80d4bf1e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "660505e44d662e186018b6bfae9bb033ffe3d48a863ab34c2ed29cf497073b54"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "346586de1fdc7b3348651b1cd4a122534fa8a79d9c8c4ac6e97aaa04d6ce6355"
    sha256 cellar: :any_skip_relocation, ventura:       "407b2744c5d3fb056e1e1ec9d5cb310b7c310033349f86e304ec78aefc6645d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "280d748ae10fdad977f5851c927dc6138b52bb934af8e53ae6b0e643941376b7"
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
