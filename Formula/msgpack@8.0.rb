# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT80 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bbd076ffc5b270f1e8508739b765bb92744d3b5572c9a096b205be7d9201c060"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "19b5eeefd29eb122db7168f42fede10bfc6053f537b29cfc21c741a95ef01e4b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1c13f4cf6eb08b393370fae9241601c4adc2409b7bf7d507ccd483f5bbf6e095"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "48417052101985ab0dc8fa42da36777f3b9992624ce21064b682fb603f5b95d8"
    sha256 cellar: :any_skip_relocation, sonoma:        "162c23fff5bf21271f2da8608e395036d5345c532a82cc8b4979c8514e3d7e2f"
    sha256 cellar: :any_skip_relocation, ventura:       "69c0536d5c0ba9bb7a3f57643481486b5ca6d195089c6e7d88782bcd6f1775af"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5de730c1a27d7cead0aafa777587bbb08fb11912130da12ef1e037ff255ff22b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a640332d390d269e387916c0fdc06c5f4c7a69ff8fd456fc8c20066a5292b621"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
