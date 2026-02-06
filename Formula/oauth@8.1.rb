# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT81 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-2.0.10.tgz"
  sha256 "1fd5e074dacf5149603493c454b476d69850bec0a71d7ea69a36a00db728a0fb"
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "534cfaef8af0a5ad834854d0b6d79e580fe8db9a0e28615998b45feaab6802f6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fd9683d5ce8889b75e4478b43899802b545ad27043e93561dde1ac9c6938ec94"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "01d7c3a18407c7c4531e79ebf65f9604cf62ade007a3f479069008077d54656d"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ea945e79844e7b134b30dba6d388777bfa123ef5f20f3fdb800dceab6bf49c4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a0955ebf16307116d496e9523c897b8d2d885152d63b34a4d1145b7951047809"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4bd8ca7912071dea1d291be0950852bddc29612d9e6b53710a2d18e0a41dd13a"
  end

  depends_on "curl"

  def install
    Dir.chdir "oauth-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-oauth"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
