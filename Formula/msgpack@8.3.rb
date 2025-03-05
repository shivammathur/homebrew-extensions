# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "80e64fd5a79d77d71129bad16279d91571ffd0a5f91cc7753dea45df01b0d692"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "61360f223b6af78f5aa936c0ad7c1f0c92d7fe63f93b62ea9028676349a16765"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c2f2c49f8218106c1b129d15f299094bc408e63811c4c9b4e3312f424ea16416"
    sha256 cellar: :any_skip_relocation, ventura:       "818a6b3e453978954ef39c4649e313c9ec9a441cab79cca610553e3b37c6f5ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "af5b7558676dc7637943b579584022363690f97b3d2751bcf66e532278a34d1f"
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
