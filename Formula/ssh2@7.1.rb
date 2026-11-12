# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT71 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.0.tgz"
  sha256 "2342df367fb01a789a1b9f6c9c780f5221c51e9c00bf1cd1dd8a5c38b98d4cc5"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_golden_gate: "e178ccd133f0c6c2fed6fe9d2aad3d5c19f9e116b138348546035cf4b5306cc3"
    sha256 cellar: :any,                 arm64_tahoe:       "33c48d9e5d96c804208b291da0606be2b5bde5eda5e6efbec0951597577793cb"
    sha256 cellar: :any,                 arm64_sequoia:     "d130a3356bc80b143c9b516e2c3510ba2836b12696e5254018465f82d6073c51"
    sha256 cellar: :any,                 arm64_sonoma:      "1cc2c9f5dfdc428418bb1447c11722870b669fc972fafde459aedc49e2e3a3d6"
    sha256 cellar: :any,                 sonoma:            "311154c289c39c9f962c496c3c28085482c9815100877fe45448a247d2879d47"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "f65c9e308151970cc65b84827eacd3c88ba57ee3f005dbec9ef00f6400c668df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "46fd6caf29aa5e6c5b6d7b3373b7a29d11ac37b66b4c042a06b014113be2c978"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "#include \"Zend/zend_attributes.h\"\n", ""
    inreplace "ssh2_fopen_wrappers.c" do |s|
      s.gsub! "ZSTR_VAL(resource->path)", "SSH2_URL_STR(resource->path)"
      s.gsub! "zend_string_release(resource->path);", "efree(resource->path);"
      s.gsub! "zend_string_init(path_in_original, strlen(path_in_original), 0)", "estrdup(path_in_original)"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
