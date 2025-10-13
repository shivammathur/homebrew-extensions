# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT56 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.8.tar.gz"
  sha256 "96d2ff56db2b307b03f848028decb780cb2ae7c75fa922871f5f3063c7a66cb2"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "ee83c892e3205795f27e3faa8d3855d96851459328f7bd0c5e42b18a725b0238"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "915704a7c6df2ae48ec8be8976c2d2a433ccdf927438fb8cbb22ab24c88e95eb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3ec13c2182c3ee056a84a746a748ae4f0c786918069496f49b04bda9ca70ad18"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a03052a599937f6d9f924f7d3f2a2b775e8a4bdc032726fab0396135ccdcc235"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cbfebbb94d5c640321ad00dd67e5a5889b594129b7508c3611a297da4de267f0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f58af98b9aa9978de51abe76440e2ee6bb41593b912ada388c81184f710953b3"
    sha256 cellar: :any_skip_relocation, ventura:        "85e222ddc9d0d7cf36c4ea914557a5745868a49f1adad614a1cc3435ff282097"
    sha256 cellar: :any_skip_relocation, monterey:       "c8a1ad6280ee62f00ed40edab7a7c3af5bed843a901866333b65d7d61e773a07"
    sha256 cellar: :any_skip_relocation, big_sur:        "436b4bfb446b0a54f0cff55ff5af4370807a780252edd42f9c0bc2b2c5ac18cf"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "62683e5494f43605df67ada2e8099454a1826e12480e4ada9997f0adf1891bf1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ba096605e18c5ea810cbce9b0d17a51670911abdb7c518a91ee68f4f8387a5d8"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php5"
    add_include_files
  end
end
