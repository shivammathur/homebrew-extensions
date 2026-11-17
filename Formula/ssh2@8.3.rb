# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT83 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.1.tgz"
  sha256 "2212d8266df54654b282ca681ee9b82f312a776e801b667b288d80f3541741ed"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "121a6f649ff4f85a1137f96bff884f636d6bf9ed47cd3d36ffeb38a8af304ee0"
    sha256 cellar: :any, arm64_tahoe:       "78f8be566d4fc53e9526cbc4abe85ba7860a6926a2db7378e9df1be3b9fd7364"
    sha256 cellar: :any, arm64_sequoia:     "c9978a9f89d1c97903d855a81adfc47134a8152f6e32ed95d59248c4b8da1149"
    sha256 cellar: :any, arm64_linux:       "26be998d56158ca7593813cb89164a98601ddb8e0560a0c3f335bffcda166f23"
    sha256 cellar: :any, x86_64_linux:      "e980a5de2b5cdb07dbb8ceeff04da0e11883fa7691705e291bee83d005a46ba2"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
