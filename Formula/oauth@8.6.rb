# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT86 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-2.0.10.tgz"
  sha256 "1fd5e074dacf5149603493c454b476d69850bec0a71d7ea69a36a00db728a0fb"
  revision 3
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7f40550dab2274311aeb3f438c0b87f4663c04d03735f0a6eb5539920ca8f90e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "b6a09ef4aa6e38ed8e6ee13281e0a69ac178178a520ea87624a61e43ac799b2a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "b92e52c4576ca11b18bdde984fc3226f716823b314c0a0236c0218a61d4f4d41"
    sha256 cellar: :any,                 arm64_linux:       "0fdc96932e4a756c5c80f89ed5701242e65ca66b014ce15e20a828717f4b09dd"
    sha256 cellar: :any,                 x86_64_linux:      "3e32bc1cf7a9aba34dd161eaf8a0602eda54fdc964b7e2476933e7146d5e47b3"
  end

  depends_on "curl"

  def install
    Dir.chdir "oauth-#{version}"
    inreplace %w[
      oauth.c
      php_oauth.h
      provider.c
      provider.h
    ], "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-oauth"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
