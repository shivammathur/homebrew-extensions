# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "e65d2093cadc15397af2e8940b5130b32488420c768bd983486ac5eb921cefaa"
    sha256 cellar: :any, arm64_tahoe:       "8eb81db6c766632d0d252eb2c3f4c46f13e1c976884735d52389677663b8b05b"
    sha256 cellar: :any, arm64_sequoia:     "2f694e2d7cdc00b8756b4071f776bc1f69e1bea42faad3943f99807d933d0f2a"
    sha256 cellar: :any, arm64_linux:       "e216c8d13b9b4192284b767ad5d5bbcd4f25fcff8190bf6b597d75d75d9f6361"
    sha256 cellar: :any, x86_64_linux:      "4315977d3b7e85ef6cae6f0e598d3bc95c236a966ea77ede3a91d795ea116baa"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "#include \"Zend/zend_attributes.h\"\n", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
